#include <unordered_map>

#include "Item.hpp"

typedef unsigned int Key;
typedef std::unordered_map<Key, Item> Map;
class ItemMap {
   private:
    Map *m_Map;

   public:
    ItemMap() {}
    void SetItem(Key &key, Item &item());
    Item GetItem(Key &key);
    auto GetMapSize();
};