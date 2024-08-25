RSpec.shared_examples 'is valid' do
  specify 'returns valid after ActiveRecord action' do
    expect(valid_result).to be_valid
  end
end

RSpec.shared_examples 'is invalid' do
  specify 'returns invalid after ActiveRecord action' do
    expect(invalid_result).not_to be_valid
  end
end

RSpec.shared_examples 'json result' do |with_headers: false|
  specify 'returns JSON' do
    with_headers ? api_call(params, headers: send(:headers)) : api_call(params)
    expect { JSON.parse(response.body) }.not_to raise_error
  end
end

RSpec.shared_examples 'json expected values' do
  specify 'returns JSON with expected values' do
    api_call params
    expect(response.body).to include_json(
      expected_values
    )
  end
end

RSpec.shared_examples 'valid API response' do |with_headers: false|
  # it_behaves_like 'includes expected response headers', with_headers: with_headers
  it_behaves_like 'json result', with_headers: with_headers
end

RSpec.shared_examples '200' do |with_headers: false|
  specify 'returns 200' do
    with_headers ? api_call(params, headers: send(:headers)) : api_call(params)
    expect(response.status).to eq(200)
  end
end

RSpec.shared_examples '201' do
  specify 'returns 201' do
    api_call params
    expect(response.status).to eq(201)
  end
end

RSpec.shared_examples '202' do
  specify 'returns 202' do
    api_call params
    expect(response.status).to eq(202)
  end
end

RSpec.shared_examples '204' do
  specify 'returns 204' do
    api_call params
    expect(response.status).to eq(204)
  end
end

RSpec.shared_examples '400' do
  specify 'returns 400' do
    api_call params
    expect(response.status).to eq(400)
  end
end

RSpec.shared_examples '401' do |with_headers: false|
  specify 'returns 401' do
    with_headers ? api_call(params, headers: send(:headers)) : api_call(params)
    expect(response.status).to eq(401)
  end
end

RSpec.shared_examples '403' do
  specify 'returns 403' do
    api_call params
    expect(response.status).to eq(403)
  end
end

RSpec.shared_examples '404' do
  specify 'returns 404' do
    api_call params
    expect(response.status).to eq(404)
  end
end

RSpec.shared_examples '406' do
  specify 'returns 406' do
    api_call params, headers
    expect(response.status).to eq(406)
  end
end

RSpec.shared_examples '422' do |with_headers: false|
  specify 'returns 422' do
    with_headers ? api_call(params, headers: send(:headers)) : api_call(params)
    expect(response.status).to eq(422)
  end
end

RSpec.shared_examples '449' do
  specify 'returns 449' do
    api_call params
    expect(response.status).to eq(449)
  end
end
RSpec.shared_examples '500' do
  specify 'returns 500' do
    api_call params
    expect(response.status).to eq(500)
  end
end

RSpec.shared_examples 'contains inner_error message' do |message|
  specify "error is #{message}" do
    api_call params
    json = JSON.parse(response.body)
    expect(json['error']['inner_error']).to eq(message)
  end
end

RSpec::Matchers.define_negated_matcher :not_change, :change
