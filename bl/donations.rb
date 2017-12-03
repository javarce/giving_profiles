$donations = $mongo.collection('donations')

DONATION_FIELDS = [:user_id, :org_name, :org_id, :amount]

def user_donations(user_id)
  #return $donations.all
  $donations.get_many(user_id: user_id).reverse 
end

def user_causes_hash(user)
  donations = user_donations(user['_id'])
  org_ids   = donations.mapo('org_id').uniq
  orgs      = $orgs.get_many(_id: {'$in': org_ids})
  causes    = orgs.mapo('type').compact
  causes_h  = causes.hash_of_num_occurrences #by num of organizations
rescue => e
  {}
end

post '/donations' do
  amount = pr[:amount].to_i
  data   = pr.just(DONATION_FIELDS)
  name   = pr[:org_name]
  #org    = $orgs.get(name: Regexp.new(name, Regexp::IGNORECASE))
  org    = $orgs.get(name: name)
  halt_back("No such organization: #{name}") if !org
  halt_back("Amount must be positive") if !(amount > 0)
  
  data[:org_id] = org[:_id]
  data[:user_id] = cuid
  
  $donations.add(data)
  
  flash.message = 'Thanks!'
  redirect back
end

get '/donations/delete' do
  don = $donations.get(pr[:id])
  halt unless don[:user_id] == cuid
  $donations.delete_one(_id: pr[:id])
  flash_and_back('Donation deleted.')
end