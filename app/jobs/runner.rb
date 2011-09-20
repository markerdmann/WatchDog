class Runner
  @queue = :runner
  
  def self.perform(task_id)
    REDIS.set('p', 1)
    begin
      REDIS.set('p', 1.5)
      task = Task.find(task_id)
      REDIS.set('p', 2)
      return unless task.running
      agent = Mechanize.new
      page = agent.get(task.url + "?key=#{task.api_key}")
      selector = task.css_selector
      values = page.search(selector).map {|el| el.text }
      REDIS.set('p', 3)
      if task.extract_number
        values.map! {|v| v.scan(/\d+/)[0].to_i }
      end
      values.select! {|v| v > task.threshold }
      if !values.empty?
        TaskMailer.alert_email(task, values).deliver
      end
      REDIS.set('p', 4)
      Resque.enqueue_in(task.frequency.to_f.hours, Runner, task_id)
      REDIS.set('p', 5)
    rescue => e
      REDIS.set('error', [e.inspect, e.backtrace].to_json)
    end
  end
end