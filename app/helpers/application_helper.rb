module ApplicationHelper
  def task_status(status)
    return 'Done' if status == true
    'Pending'
  end
end
