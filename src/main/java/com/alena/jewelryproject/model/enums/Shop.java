package com.alena.jewelryproject.model.enums;

public enum Shop {
    GREEN_BIRD("greenBird"),
    PANDAHALL("pandahall"),
    STILNAYA("stilnaya"),
    LUXFURNITURA("luxfurnitura"),
    OTHER("other"),
    ;

    private String id;

    Shop(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public static Shop getShopById(String id) {
        for (Shop shop : Shop.values()) {
            if (shop.getId().equals(id)) {
                return shop;
            }
        }
        return null;
    }


}
