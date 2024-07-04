STEAM_DB = YAML.load_file(
    "#{Rails.root}/config/database.yml",
    aliases: true
)['steam'] || YAML.load_file(
    "#{Rails.root}/config/db.yml",
    aliases: true
)['steam']