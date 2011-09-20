class Runner
  @queue = :runner
  
  def self.perform(task_id)
    begin
      task = Task.find(task_id)
      return unless task.running
      agent = Mechanize.new
      page = agent.get(task.url + "?key=#{task.api_key}")
      selector = task.css_selector
      values = page.search(selector).map {|el| el.text }
      if task.extract_number
        values.map! {|v| v.scan(/\d+/)[0].to_i }
      end
      values.select! {|v| v > task.threshold }
      if !values.empty?
        TaskMailer.alert_email(task, values).deliver
      end
      Resque.enqueue_in(task.frequency.to_f.hours, Runner, task_id)
    rescue => e
      REDIS.set('error', [e, e.backtrace].to_json)
    end
  end
end