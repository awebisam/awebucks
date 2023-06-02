from brownie import accounts, AweBucks, config, network

def main():
    deployer = accounts.add(config["wallets"]["from_key"])

    name = "AweBucks"
    symbol = "AWB"
    decimals = 2
    initialSupply = 100_000_000_000

    token = AweBucks.deploy(name, symbol, decimals, initialSupply, {'from': deployer}, publish_source=config["networks"][network.show_active()]["verify"] or False)

    print("AweBucks Token deployed at:", token.address)
