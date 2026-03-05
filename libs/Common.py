import re
#Pour faire des remplacements avec expressions régulières (re.sub)
# → supprimer les caractères interdits dans le nom de fichier

import unicodedata
#Pour normaliser les caractères accentués et pouvoir les supprimer facilement

def clean_string_filename(str):
    # Supprime les caractères interdits pour les noms de fichiers
    clean1 = re.sub(r'[\\/*?:"<>| ]',"",str)
    # Supprime les accents
    clean2 = ''.join((c for c in unicodedata.normalize('NFD', clean1) if unicodedata.category(c) != 'Mn'))
    return clean2