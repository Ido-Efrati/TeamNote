json.array!(@notes) do |note|
  json.extract! note, :title, :user, :content
  json.url note_url(note, format: :json)
end
