module ApplicationHelper
  def bootstrap_classes
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
      danger: 'alert-danger'
    }
  end

  def bootstrap_class_for(flash_type)
    bootstrap_classes.fetch(flash_type.to_sym) || flash_type.to_s
  end
end
