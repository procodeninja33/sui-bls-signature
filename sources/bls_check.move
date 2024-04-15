module storage_bls::bls_check {
    use sui::tx_context::TxContext;
    use sui::bls12381;
    use sui::hex;

    /// Signature verification failed
    const EINVALID_SIGNATURE: u64 = 11;

    public entry fun verify_bls_signature(signature: vector<u8>, public_key: vector<u8>, msg: vector<u8>, _ctx: &mut TxContext) {
        let result = bls12381::bls12381_min_sig_verify(&signature, &public_key, &msg);
        assert!(result, EINVALID_SIGNATURE);
    }

    public entry fun check_bls_signature(_ctx: &mut TxContext) {
        let signature = hex::decode(b"8861e505603cd10968ae0eff41000296b7a44569ae66b3875c608a20b06dece871e2550c0e9dec35d71d08790d2b10aa");
        let public_key = hex::decode(b"a8f329778e9442369451db74a2c168c3065ec5094af78a7ce9eb1d9d372dbd0d32f6ae9cdfbd303cb8da5dd35b5fd4ae057eb0172f1d20e821013dbdfe0f0c7e775011fde0f08c6a72eecc5d3a39ac1d3accec977e879f6fbf25188f74188ec5");
        let msg = hex::decode(b"e78f6608dce8a4134d76b493914bb01e9fedd8cb60a8a0eff3d38aba12f11898");
        let result = bls12381::bls12381_min_sig_verify(&signature, &public_key, &msg);
        assert!(result, EINVALID_SIGNATURE);
    }
}
