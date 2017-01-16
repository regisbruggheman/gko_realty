@site = Site.first
@main_page = @site.sections.find_by_name('main')
@user = User.first
@account = Account.first

['Salines','Gouverneur','Gustavia','Saint-Jean','Saint-jean Carénage','Anse Des Lézards','Merlette','La Grande Vigie','Lorient','Flamands','Colombier','Toiny','Grands-Fonds','Cul-de-Sac','Petit Cul-de-Sac','Anse des Cayes','Quartier du Roy','Tourterelle','Lurin','Corossol','Vitet','Devet','Marigot','Pointe Milou','Public'].each do |area|
  Area.create!(:name => area)
end

####################################################
puts "creating images"
@files = Dir["#{File.dirname(__FILE__)}/images/*.jpg"]
puts "creating images ... #{@files.join(',')}"

@files.each do |file|
  @site.images.create!(
      :image => File.new(file),
      :author => @user,
      :account => @account)
end

####################################################

puts "creating rental properties pages"
@rental_property_list = RentalPropertyList.create!(
  :title => "Villas à la location", 
  :site_id => @site.id,
  :parent_id => @main_page.id,
  :accept_categories => true,
  :accept_stickers => true,
  :published_at => now)
  
  ["villa","appartement"].each do |cat|
    Category.create!(
      :title => cat,
      :section_id => @rental_property_list.id
    )
  end

  ["Piscine","Vue mer","Jaccuzzi", "air conditionné"].each do |name|
    Sticker.create!(
      :name => name,
      :section_id => @rental_property_list.id
    )
  end
  
  
  
  10.times do |i|
    bedroom_count = rand_int(1, 8)

    @rental_property = @rental_property_list.rental_properties.create!(
      :title => "Villa #{i}",
      :body => lorem,
      :published_at => now,
      :meta_attributes => {
        :bedroom_count => bedroom_count,
        :bathroom_count => rand_int(1, 3),
        :room_count => rand_int(bedroom_count + 1, bedroom_count + 4),
        :max_guest => bedroom_count*2,
        :area => random_resource(Area)
      })
    
    assign_images_to_content(@rental_property)  
    @rental_property.categorizations.create(:category_id => 1)
    
    2.times do
      if(image = random_resource(Image))
        @rental_property.image_assignments.create(:image => image)
      end
    end

    puts "creating properties seasons"
    
    @start_date = now;
    @end_date = @start_date + 3.months;
    4.times do |i|
      @rental_property.rental_property_seasons.create(
        :title => "Season #{i}",
        :start_date => @start_date,
        :end_date => @end_date
      )
      @start_date = @end_date
      @end_date = @start_date + 3.months;
    end

    puts "creating properties rates"
    @rental_property.meta.bedroom_count.times do |i|
      @rental_property.rental_property_seasons.each do |season|
        season.rates.create!(
          :eur_price => rand_price(2000, 12000),
          :usd_price => rand_price(2000, 12000),
          :bedroom_count => i
        )
      end
    end
  end


####################################################

puts "creating sale properties pages"
@sale_property_list = SalePropertyList.create!(
  :title => "Villas à la vente", 
  :site_id => @site.id,
  :parent_id => @main_page.id,
  :accept_categories => true,
  :accept_stickers => true,
  :published_at => now)
10.times do |i|
  @sale_property = @sale_property_list.sale_properties.create!(
    :title => "Villa #{i}",
    :body => lorem,
    :published_at => now,
    :meta_attributes => {
      :price => rand_price(500000, 3000000),
      :area => random_resource(Area)
    })
  2.times do
    @sale_property.image_assignments.create(:image => random_resource(Image))
  end
end
puts "END"
