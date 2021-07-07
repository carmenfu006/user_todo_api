module ApplicationHelper
  def task_status(status)
    return 'Done' if status == true
    'Pending'
  end

  def task_action(status)
    return 'Uncheck' if status == true
    'Check'
  end
end
