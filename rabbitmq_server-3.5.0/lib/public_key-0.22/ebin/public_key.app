{application, public_key,
  [{description, "Public key infrastructure"},
   {vsn, "0.22"},
   {modules, [	  public_key,
		  pubkey_pem,
		  pubkey_pbe,	
		  pubkey_ssh,
		  pubkey_cert,
		  pubkey_cert_records,
		  pubkey_crl,
		  'OTP-PUB-KEY',
		  'PKCS-FRAME'
            ]},
   {applications, [asn1, crypto, kernel, stdlib]},
   {registered, []},
   {env, []},
   {runtime_dependencies, ["stdlib-2.0","kernel-3.0","erts-6.0","crypto-3.3",
			   "asn1-3.0"]}
   ]
}.

