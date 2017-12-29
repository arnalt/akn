class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
  belongs_to :project
  belongs_to :task

  before_create :complete_work
  before_update :complete_work

  validates :date, :start_at, :end_at, :pause, :client_id, presence: true


  def self.build_report(start_at, end_at, project_id)
    where("date >= ? and date <= ? and project_id = ?", start_at, end_at, project_id)
  end

  def self.build_works_by_task(task_id)
    where("task_id = ?", task_id)
  end

  def self.report_passed(user_id, start_at, end_at, projectt_id)
    where("user_id = ? and date >= ? and date <= ? and project_id = ?", user_id, start_at, end_at, project_id).update_all(:passed => true)
  end

  def self.works_finalize(user_id, date)
    where("user_id = ? and date <= ?", user_id, date).update_all(:passed => true)
  end

  def self.report_unpassed(user_id, start_at, end_at, project_id)
    where("user_id = ? and date >= ? and date <= ? and project_id = ?", user_id, start_at, end_at, project_id).update_all(:passed => false)
  end

  def self.statistics_build(user_id, year, month, task_id, ta_id)
    where("user_id = ? and year = ? and month = ? and task_id <> ? and task_id <> ?", user_id, year, month, task_id, ta_id).sum(:working_hours)
  end

  def self.statistics_holidays(user_id, year,month, task_id)
    where("user_id = ? and year = ? and month = ? and task_id = ? ", user_id, year, month, task_id).sum(:working_hours)
  end

  def complete_work
    self.year = self.date.year.to_int
    self.month = self.date.to_s[5, 2].to_i
   # self.project_id = Task.find(self.task_id).project_id
    #self.client_id = Project.find(self.project_id).client_id

    @arr = I18n.t("date.day_names")
    self.day = @arr.at(self.date.wday)
    self.week = self.date.strftime("%W").to_i
    if  Task.find(self.task_id).name == 'Urlaub'
      self.working_hours = 8.0
      self.end_at = '16:00'
      self.start_at = '08:00'
      self.pause = '00:00'
    else
      self.working_hours = ((((self.end_at.hour * 60) + self.end_at.min) - ((self.start_at.hour * 60) + self.start_at.min)) - ((self.pause.hour * 60) + self.pause.min)) / 60.0
    end
  end

   def self.give_years
        self.select(:year).group('year')
   end


  def self.total_on(date, work)
    where("date = ? AND user_id = ? AND project_id = ? ", date, work.first.user_id, work.first.project_id).sum(:working_hours)
  end

  def self.get_avg(start_at, end_at, project_id)
    self.build_report(start_at, end_at, project_id).average(:working_hours)
  end

  def self.get_min(start_at, end_at, project_id)
    self.build_report(start_at, end_at, project_id).minimum(:working_hours)
  end

  def self.get_max(start_at, end_at, project_id)
    self.build_report(start_at, end_at, project_id).maximum(:working_hours)
  end

  def self.get_days(start_at, end_at, project_id)
    self.build_report(start_at, end_at, project_id).count
  end
end
