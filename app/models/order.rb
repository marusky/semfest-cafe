class Order < ApplicationRecord
  validates :number, :color, presence: true
  validate :unique_number_in_color

  after_create_commit :turbo_update_order
  after_update_commit -> { broadcast_render_to :orders, partial: 'orders/update'}, if: :correct_flow?
  after_update_commit -> { broadcast_render_to :orders, partial: 'orders/rollback'}, if: :incorrect_flow?

  enum progress: {
    preparing: 'preparing',
    ready: 'ready',
    delivered: 'delivered'
  }

  enum color: {
    red: 'red',
    green: 'green',
    blue: 'blue',
    yellow: 'yellow'
  }

  def bootstrap_text_color
    case color
    when 'red'
      'my-red'
    when 'green'
      'my-green'
    when 'blue'
      'my-blue'
    when 'yellow'
      'my-yellow'
    end
  end

  def progress_in_words
    case progress
    when 'preparing'
      'Pripravuje sa...'
    when 'ready'
      'Čaká na odovzdanie.'
    when 'delivered'
      'Odovzdaná'
    end
  end

  def action_message_in_words
    case progress
    when 'preparing'
      "Objednávka č. #{number} (#{slovak_color}) bola úspešne vytvorená."
    when 'ready'
      "Objednávka č. #{number} (#{slovak_color}) je pripravená."
    when 'delivered'
      "Objednávka č. #{number} (#{slovak_color}) bola odovzdaná."
    end
  end

  private

  def unique_number_in_color
    order = Order.find_by(color: color, number: number)
    return unless order.present? && order.id != id

    errors.add(:base, 'Objednávka s rovnakým číslom a farbou už existuje.')
  end

  def correct_flow?
    saved_change_to_progress?(from: :preparing, to: :ready) ||
      saved_change_to_progress?(from: :ready, to: :delivered)
  end

  def incorrect_flow?
    saved_change_to_progress?(from: :ready, to: :preparing) ||
      saved_change_to_progress?(from: :delivered, to: :ready)
  end

  def turbo_update_order
    broadcast_append_to :orders
    broadcast_append_to :orders, partial: "orders/number", target: 'orders-in-preparation'
  end

  def slovak_color
    case color
    when 'blue'
      'modrá'
    when 'red'
      'červená'
    when 'yellow'
      'žltá'
    when 'green'
      'zelená'
    end
  end
end
