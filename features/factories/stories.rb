Factory.define :story do |s|
  s.title "Title"
  s.intro "Introducction"
  s.content "Lorem Ipsum... "
  s.association :section, :factory => :story_section
  s.draft false
  s.date Time.zone.now
  s.association :user, :factory => :user
end
