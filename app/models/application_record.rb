class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Loads every has_one_attached attachment of this record (with its blob) in
  # ONE query and primes the *_attachment associations, so later
  # `foo.attached?` / `url_for(foo)` calls don't each pay their own round trip
  # to the remote DB. Returns self for chaining.
  def preload_single_attachments
    names = self.class.reflect_on_all_attachments.select { |r| r.macro == :has_one_attached }.map { |r| r.name.to_s }
    return self if names.empty? || new_record?

    found = ActiveStorage::Attachment.eager_load(:blob)
                                     .where(record_type: self.class.polymorphic_name, record_id: id, name: names)
                                     .index_by(&:name)
    names.each { |name| association(:"#{name}_attachment").target = found[name] }
    self
  end
end
