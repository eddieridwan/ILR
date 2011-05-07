class AddTestData < ActiveRecord::Migration
  def self.up
    Product.create(
    :productid => 'ILR01',
    :title => 'Indonesian Primer',
    :description => 
      %{<p>
        The Indonesian Primer is a CD-ROM for beginning learners in Bahasa Indonesia. 
        Use it to build your skills in Indonesian pronunciation and vocabulary the 
        fast and fun way. You can listen to native Indonesian speakers pronounce hundreds of words. 
        Each section has a learning and testing mode, using authentic Indonesian daily 
        life scenes to put the vocabulary in context. For additional challenge, 
        you can create your own scenes incorporating words from the 1000+ word on-line dictionary.
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
      </p><p>
        Start with the basics, perfect your pronunciation with Sounds by listening to the native speakers 
        pronounce Indonesian syllables. Then test your understanding with the listening comprehension game.
      </p><p>
        Build your Indonesian vocabulary the interactive way using the Vocabulary Builder. 
        Fourteen daily life scenes teach and test hundreds of words pronounced by native 
        Indonesian speakers. After you've mastered each scene, test your skills using the fun games.
      </p><p>
        Master counting quickly and easily using the Numbers section. 
        From simple numbers to six digit figures, Indonesian Primer will have you 
        counting like a native speaker. Then practice counting skills using objects 
        encountered in every day life in Indonesia.
      </p>
      <p><strong>System Requirements:</strong></p>
        <ul>
            <li>Microsoft Windows XP/Vista</li>
            <li>8MB RAM</li>
            <li>CD-ROM drive</li>
            <li>Sound card and speakers</li>
            <li>Mouse</li>
        </ul>
      },
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
        This CD is ideal for travellers to Indonesia and students at 
        beginner and intermediate levels. More than 100 topics covering 
        an extensive range of subject areas likely to be encountered in 
        everyday situations. Designed not only for learning, but also 
        as a reference and an electronic phrasebook. 
      </p>
      },
    :product_details =>
      %{
      <p><b>Level:</b> Beginner, Intermediate</p>
      <p><b>Age:</b> Adult, High school</p>
      <p><b>Features:</b></p>
      <p>Perfect for the first time learner of Indonesian to quickly
      build their skills in Indonesian pronunciations and everyday
      vocabulary. An excellent reference for intermediate learners and
      casual users of Indonesian, to refresh and reinforce their
      knowledge of words and phrases useful in normal day-to-day
      activities.</p>
      
      <p>Ideal for travellers to Indonesia and students at beginner and
      intermediate levels.</p>
      
      <p>More than 100 topics covering an extensive range of subject
      areas likely to be encountered in everyday situations such as
      shopping, ordering a meal at a restaurant, introductions,
      meetings, checking in at a hotel, getting flight information at
      an airport, banking and many others. Also includes general topics
      such as the alphabet, numbers, grammar, colour, size, shape,
      taste and feelings. Spoken dialogues illustrate realistic use of
      words and phrases in everyday conversation. Grammar and usage
      notes provide practical information. </p>
      
      <p>Reinforce learning through many interactive activities
      including date/time exercises, number exercises, letter sound
      exercises, word exercises, phrase exercises and word-picture
      exercises.</p>
      
      <p>Look up words and phrases easily from the Indonesian-English
      dictionary containing more than 4400 entries. Hear the words and phrases spoken
      by native speakers.</p>

      <p><strong>System Requirements:</strong></p>
      <ul>
          <li>Microsoft Windows XP/Vista</li>
          <li>8MB RAM</li>
          <li>CD-ROM drive</li>
          <li>Sound card and speakers</li>
          <li>Mouse</li>
      </ul>
      },
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
       WordExplorer is more than just an Indonesian-English dictionary. 
       It has lots of easy to use features to explore and understand Indonesian terms and their English meanings. 
       Sample sentences and their translations are provided so that you can see how the words are used for 
       each of their different meanings.
      </p>},
    :product_details =>
    %{
      <p><b>Features:</b></p>
      <p>WordExplorer is more than just an Indonesian-English
      dictionary. It has lots of easy to use features to explore and understand
      Indonesian terms and their English meanings.</p>
      <p>Features include:</p>
      <ul>
        <li>Search using Indonesian or English terms. You can search for derived terms
          (e.g. <i>menutup</i>) without having to know the root word (e.g. <i>tutup</i>)
        <li>Displays alternative spellings of Indonesian terms, multiple meanings,
          synonyms, root words and derived forms
        <li>Web browser style interface with hyperlinks to related information
        <li>Pronunciation of Indonesian terms by native speakers
        <li>Provides the different meanings of Indonesian terms
        <li>Example sentences showing the use of terms in Indonesian and English
        <li>History List to navigate back to recently visited terms
        <li>Search for selected text
        <li>Copy and paste selected text to other applications</li>
      </ul>
      
      <p><b>Platform</b>: Windows</p>
      <p><b>System requirements:</b></p>
      <ul>
        <li>Microsoft Windows XP/Vista</li>
        <li>16 Mb RAM</li>
        <li>10 Mb available hard disk space</li>
        <li>Sound card, speakers</li>
        <li>CD-ROM drive</li>
        <li>Mouse</li>
      </ul> 
    },
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
        Combining colourful graphics and sound, this software will help you 
        develop recognition of the written word, correct pronunciation, 
        and familiarity with Bahasa Indonesia. The Bahasa Indonesia Interactive 
        programme contains a course designed in cooperation with and used by the 
        Australian and United States Defence Force School of Languages.
      </p>},
    :product_details =>
    %{
      <p><b>Level:</b> Intermediate</p>
      <p><b>Age:</b> Adult, High school</p>
      <p><b>Features:</b></p>

      <p>Combining colourful graphics and sound, this software will
      help you develop recognition of the written word, assist you in
      correct pronunciation, and strengthen your understanding of
      Bahasa Indonesia grammar and phraseology. The dialogues introduce
      you to contemporary Indonesian - Indonesian as it is spoken
      today. </p>
      
      <p>The CD contains 60 chapters of realistic scenarios, including
      'Introductions', 'At the Post Office', 'At the Doctor's Surgery',
      'Invitation to Dinner'. Each chapter contains Exercises,
      Dialogues, Vocabulary Lists, Listening and Reading tests,
      sentence scramblers, and much more.. On-line grammar and cultural
      notes provides explanations on the appropriate use of material in
      the chapters. </p>
      
      <p>The CD also has an excellent reference section. It has a map
      of the Southeast Asian region on which you can quickly locate an
      island, city or country. The reference section also provides
      information on Indonesian politics, history, people and culture.
      There is a quick reference facility to find Indonesian words for
      concepts such as time, numbers, days of the week etc, as well as
      to find sample sentences in which a particular Indonesian (and
      English) word is used.</p>
      
      <p>The Bahasa Indonesia Interactive programme contains a course
      designed in cooperation with and used by the Australian and
      United States Defence Force School of Languages.</p>

      <p><b>System requirements:</b></p>
      <ul>
        <li>Microsoft Windows XP/Vista</li>
        <li>8MB RAM</li>
        <li>20MB disk space</li>
        <li>CD-ROM drive</li>
        <li>Sound card</li>
        <li>Headphones or speakers</li>
        <li>Microphone for voice recording&nbsp; (optional)</li>
      </ul>
    },
    :publisher => "Courage Software",
    :image => 'BInteractive_100.jpg',
    :price => 35.00,
    :paypal_button_id => '35683'
    )

  def self.down
    Product.delete_all
  end
end
