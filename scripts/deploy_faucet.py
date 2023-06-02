from brownie import accounts, AweBucksFaucet, config, network, AweBucks


def main():
    deployer = accounts.add(config["wallets"]["from_key"])

    tokenAddress = AweBucks[-1] 
    faucetAmount = 10
    cooldown = 60

    faucet = AweBucksFaucet.deploy(tokenAddress, faucetAmount, cooldown, {'from': deployer}, publish_source=config["networks"][network.show_active()]["verify"] or False)

    print("Faucet deployed at:", faucet.address)
