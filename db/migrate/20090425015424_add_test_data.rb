class AddTestData < ActiveRecord::Migration
  def self.up
    Product.create(
    :productid => 'ILR01',
    :title => 'Indonesian Primer',
    :description => 
      %{<p>
       For beginners. Learn while having fun. Pronunciations.
      </p>},
    :product_details =>
      %{<p> 
        Perfect for building up your skills in Indonesian pronunciation and vocabulary the fast and fun way. 
        Listen to native Indonesian speakers pronounce hundreds of words. 
        Each section has a learning mode and a testing mode. 
        Learn by using fun interactive games based on 14 authentic Indonesian daily life scenes. 
        Switch easily between English and Bahasa Indonesia prompts for a full immersion learning experience. 
        When you're ready, use the Scene Editor to create your own scenes incorporating words from 
        the 1000+ word on-line dictionary.
      </p>
        Start with the basics, perfect your pronunciation with Sounds by listening to the native speakers 
        pronounce Indonesian syllables. Then test your understanding with the listening comprehension game.
      </p>},
    :publisher => "Language Technologies",
    :image => 'primer_100.jpg',
    :price => 20.00,
    :paypal_button_id => '35670'
    )
    Product.create(
    :productid => 'ILR02',
    :title => 'Practical Indonesian - Guide to Everyday Use',
    :description => 
      %{<p>
       For beginners and intermediate. Phrases for everyday situations. Native speakers.
      </p>},
    :product_details =>
      %{<p>
        Details of Guide to Everyday Use.
      </p>},
    :publisher => "Language Technologies",
    :image => 'guide_100.jpg',
    :price => 30.00,
    :paypal_button_id => '35681'
    )
    Product.create(
    :productid => 'ILR03',
    :title => 'Practical Indonesian - WordExplorer Indonesian-English Dictionary',
    :description => 
      %{<p>
       Dictionary. Sample usage. Pronunciations by native speakers
      </p>},
    :publisher => "Language Technologies",
    :image => 'wordexplorer_100.jpg',
    :price => 25.00,
    :paypal_button_id => '35682'
    )
  end
    Product.create(
    :productid => 'ILR04',
    :title => 'Bahasa Indonesia Interactive Learning System',
    :description => 
      %{<p>
       By Courage software, tested at ADFA
      </p>},
    :publisher => "Courage Software",
    :image => 'BInteractive_100.jpg',
    :price => 35.00,
    :paypal_button_id => '35683'
    )

  def self.down
    Product.delete_all
  end
end
