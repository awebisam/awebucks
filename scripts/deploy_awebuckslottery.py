from brownie import accounts, AweBucks, AweBucksLottery, config, network

def main():

    deployer = accounts.add(config["wallets"]["from_key"])

    # AweBucks token contract address[last deployed contract] | Replace as needed
    tokenAddress =  AweBucks[-1] 
    vrfCoordinator = config["networks"][network.show_active()]["vrf_coordinator"]
    linkToken = config["networks"][network.show_active()]["link_token"]
    keyHash = config["networks"][network.show_active()]["keyhash"]
    fee = config["networks"][network.show_active()]["fee"]
    entryFee = 10

    lottery = AweBucksLottery.deploy(
        tokenAddress,
        vrfCoordinator,
        linkToken,
        keyHash,
        fee,
        entryFee,
        {'from': deployer},
        publish_source=config["networks"][network.show_active()]["verify"] or False
    )

    print("AweBucks Lottery deployed at:", lottery.address)