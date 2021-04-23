require 'open-uri'
require 'nokogiri'

def trader

  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))


  #Récupération de la valeur des monnaies en spécifiant le bon XPath
  price_xpath = page.xpath('//tbody/tr/td[5]/div//a[@class="cmc-link"]')


  #Conversion des données brutes XPath en Array, puis suppression du symbole $ avec la methode tr
  price_array = price_xpath.search('.cmc-link').map{ |price| price.text.tr('$','') }

  #Récupération du nom des monnaies en spécifiant le bon XPath
  coin_xpath = page.xpath('//tbody/tr/td[3]//*')

  #Conversion des données brutes XPath en Array
  coin_array = coin_xpath.search('div').map{ |money| money.text }

  #Definition d'un array vide dans lequel on va push nos futur hash

  a = []

  #Fusion des deux arrays en un array de hash regroupant les monnaies et leur valeur
  a = a<<coin_array.zip(price_array).map{|k, v| {crypto:k, value: v}}

  puts a

end

trader()