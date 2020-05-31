# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class StockItem(scrapy.Item):
    # define the fields for your item here like:
    code = scrapy.Field()
    price = scrapy.Field()
    ROE = scrapy.Field()
    PER = scrapy.Field()
    BPS = scrapy.Field()
    PBR = scrapy.Field()
    pass
