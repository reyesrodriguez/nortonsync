module ApplicationHelper

	def bootstrap_class_for flash_type
   { success: "alert-success", error: "alert-error", alert: "alert-alert",
    notice: "alert-info" }[flash_type.to_sym] 
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: 'text center alert #{bootstrap_class_for(msg_type)} fade in', role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat message
      end)
      flash.clear
    end
    nil
  end
end
