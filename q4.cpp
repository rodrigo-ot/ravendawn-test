void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    std::unique_ptr<Player> player(g_game.getPlayerByName(recipient));
    if (!player) {
        player.reset(new Player(nullptr));
        if (!IOLoginData::loadPlayerByName(player.get(), recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        delete player;
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player.get());
    }
}