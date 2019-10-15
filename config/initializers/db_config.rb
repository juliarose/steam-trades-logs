
STEAM_DB = YAML.load_file("#{Rails.root}/config/database.yml")['steam'] || YAML.load_file("#{Rails.root}/config/db.yml")['steam']
#  STEAM_DB = { writing: nil,  reading: :steam } 