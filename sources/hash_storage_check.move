module storage_bls::storage_check {

    use sui::object;
    use sui::object::UID;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use sui::table;

    struct HashMsgs has key, store {
        id: UID,
        /// mapping with hash
        hashes: table::Table<vector<u8>, bool>
    }

    fun init(ctx: &mut TxContext) {
        transfer::share_object(HashMsgs { id: object::new(ctx), hashes: table::new(ctx) });
    }

    public entry fun store_hash(hash_msgs: &mut HashMsgs, hash: vector<u8>) {
        if (table::contains(&hash_msgs.hashes, hash)) {
            table::add(&mut hash_msgs.hashes, hash, true);
        } else {
            // We don't want to fail the transaction we are just skipp it here
        }
    }

    /// remove will be failed if the hash not found in the table
    entry fun remove_hash(hash_msgs: &mut HashMsgs, hash: vector<u8>) {
        table::remove(&mut hash_msgs.hashes, hash);
    }

}
