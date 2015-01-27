class Announcement < ActiveRecord::Base
  def to_param
    "#{id} #{title}".parameterize
  end

  def as_json
    {
      title: title,
      created_at: created_at.strftime("%B %e, %Y"),
      body_rendered: body_rendered
    }
  end
end
