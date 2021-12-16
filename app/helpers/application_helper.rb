module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    bootstrap_alert_class = {
      'success' => 'alert-success',
      'error' => 'alert-danger',
      'notice' => 'alert-info',
      'alert' => 'alert-danger',
      'warn' => 'alert-warning'
    }
    bootstrap_alert_class[level]
  end
end
