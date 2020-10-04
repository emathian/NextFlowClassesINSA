params.ncbi_api_key = 'ab64a4db33fc8feb2a07abae94aa7d36d809'
Channel
  .fromSRA(['SRR7646230'], apiKey: params.ncbi_api_key)
  .view()

