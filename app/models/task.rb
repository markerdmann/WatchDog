class Task < ActiveRecord::Base

  belongs_to :user

  after_create :schedule

  private
    def schedule
      Resque.enqueue(Runner, self.id)
    end
end
