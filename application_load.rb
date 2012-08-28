file = File.open('import_google_082812.tsv')
  while line = file.gets
    if ( line =~ /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)/ )
      # puts $1
      # puts $2
      app = Application.new
      app.first_name = $3.split(' ')[0]
      app.last_name = $3.split(' ')[1] || ''
      app.depaul_id = $9
      app.gpa = $6
      app.major = $5
      app.email = $4
      app.phone = $7
      app.influences = $17
      app.position = $10
      app.experience = $22
      app.campus_involvement = $20
      app.co_hosts = $14
      app.show_description = $12
      app.favorite_artists = $16
      app.famous_person = $24
      app.anything_else = $18
      puts $2
      app.created_at = DateTime.strptime($2, '%m/%d/%Y %H:%M:%S')

      app.save
    end
  end
file.close