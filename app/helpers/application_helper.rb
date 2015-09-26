module ApplicationHelper
  def method_label(method)
    case method
    when 'GET'
      'btn-success'
    when 'POST'
      'btn-primary'
    when 'PUT'
      'btn-info'
    when 'PATCH'
      'btn-warning'
    when 'DELETE'
      'btn-danger'
    end
  end
end