require 'rubygems'
require 'nokogiri'
require 'open-uri'

def mairie_christmas
  #récupération de l'annuaire du 95
  annuaire = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/"))

  #récupération uniquement des liens de l'annuaire
  liens = annuaire.css('pre/a')
  #array vide dans lequel on va push tous les hash : ville/mail

  liste = []

  #itérateur qui va parcourir chaque mairie individuellement
  liens.each do |i|
    begin
      page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/#{i.text}"))

  # récupération du nom de la commune sous la variable 'ville'
      ville = page.css('main//h1').text

  # récupération du mail de la commune sous la variable 'mail'
      mail = page.css('table.table:nth-child(1)/tbody/tr[4]/td[2]').text

  # création d'un hash avec pour clef 'ville' et pour value 'mail', chaque hash sera push dans le array 'liste' défini ligne 13
      liste << Hash[ville=>mail] 

  #rescue permet de gérer les exceptions et de forcer le code à s'exécuter même s'il y a une erreur
    rescue OpenURI::HTTPError, URI::InvalidURIError
    end
  end
  return  liste
end

puts mairie_christmas

