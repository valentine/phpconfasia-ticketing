class OrdersMailer < ApplicationMailer
  def payment_started(purchase_order)
    @purchase_order = purchase_order
    @event = purchase_order.event
    @input_address = @purchase_order.transaction_details_hash[:input_address]

    mail(to: @purchase_order.payer_email, bcc: @event.contact_email, subject: "[#{@event.name}] Ticket Purchase Order - #{@purchase_order.created_at.strftime('%e-%b-%Y')}")
  end

  def payment_successful(purchase_order)
    @purchase_order = purchase_order
    @event = purchase_order.event

    mail(to: @purchase_order.payer_email, bcc: @event.contact_email, subject: "[#{@event.name}] Ticket Payment Received - #{@purchase_order.invoice_no} - #{@purchase_order.purchased_at.strftime('%e-%b-%Y')}")
  end

  def attendee_notification(purchase_order, ticket)
    @purchase_order = purchase_order
    @event = purchase_order.event
    @ticket = ticket
    @attendee = ticket.attendee

    logo_path = File.join(Rails.root, 'app', 'assets', 'images', 'krgh_facade_day.png')
    attachments.inline['krgh_facade_day.png'] = File.read(logo_path)

    map_path = File.join(Rails.root, 'app', 'assets', 'images', 'nuss_krgh_map.jpg')
    attachments.inline['nuss_krgh_map.jpg'] = File.read(map_path)

    travel_instructions = File.join(Rails.root, 'app', 'assets', 'NUSS_Location_Map.pdf')
    attachments['NUSS_Location_Map.pdf'] = File.read(travel_instructions)

    mail(to: @ticket.attendee.email, bcc: @event.contact_email, subject: "[#{@event.name}] Event Ticket (#{@ticket.order.ticket_type.name}) - #{@purchase_order.purchased_at.strftime('%e-%b-%Y')}")
  end
end
