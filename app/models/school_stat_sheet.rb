class SchoolStatSheet

  def initialize(args)
    @school = args[:school]
    @week = args[:week]
    @commitments = @school.commitments
    @students = @school.students
  end

  def stats
    {
      "Commitments To Date" => commitments_to_date,
      "Commitments per DT Member" => commitments_per_dt_member,
      "Coaching Sessions to Date" => coaching_sessions_to_date,
      "% DT with Coaching Sessions" => percent_dt_with_coaching_sessions,
      "Engaged Students" => engaged_students,
    }
  end

  def commitments_to_date
    @commitments.count
  end

  def commitments_per_dt_member
    dt = @students.select{|s| s.dream_team == true }
    if dt.count > 0
      dt.map { |student| (student.commitments || []).count }.inject(:+).to_f.fdiv(dt.count).round(2)
    else
      0
    end
  end

  def coaching_sessions_to_date
    @commitments.select{|c| c["Engagement Type"] == "Coaching Session (1 on 1)" }.count
  end

  def percent_dt_with_coaching_sessions
    dt = @students.select{|s| s.dream_team == true }
    if @school.tfpid == "NYC-NEST"
      binding.pry
    end
    if dt.count > 0
      coaching_sessions = dt.select{ |dreamer| dreamer["# Coaching Sessions"].to_i > 0 }
      (coaching_sessions.count.fdiv(dt.count).round(2) * 100).to_i
    else
      0
    end
  end

  def engaged_students
    s = @students.select do |student|
      student["Projects Count"].to_i > 0 || student["Commitments Count"].to_i > 0 || student["Engagements Count"].to_i > 0
    end
    s.count
  end

end
