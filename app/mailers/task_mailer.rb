class TaskMailer < ActionMailer::Base
  default from: "WatchDog <mark.erdmann+watchdog@gmail.com>"
  
  def alert_email(task, values)
    @task = task
    @values = values
    mail(:to => task.user.email, :subject => "Alert on Task '#{task.name}'")
  end
end
