# Attaches on-brand placeholder illustrations to any category that has no
# image yet. Safe to re-run: categories that already have an image are
# skipped, so this never overwrites an admin-uploaded photo.
namespace :category_images do
  desc "Attach default illustrations to categories missing an image"
  task attach_defaults: :environment do
    defaults = {
      /dairy/i          => "dairy_products.svg",
      /\boil/i          => "oils.svg",
      /grain|millet/i   => "grains_millets.svg"
    }
    assets_dir = Rails.root.join("app", "assets", "images", "categories")

    Category.find_each do |category|
      next if category.has_image?

      _, filename = defaults.find { |pattern, _| category.name.to_s.match?(pattern) }
      unless filename
        puts "Skipping ##{category.id} #{category.name}: no default illustration matches this name"
        next
      end

      path = assets_dir.join(filename)
      category.image.attach(
        io: File.open(path),
        filename: "#{category.name.parameterize}.svg",
        content_type: "image/svg+xml"
      )
      puts "Attached #{filename} to ##{category.id} #{category.name}"
    end
  end
end
