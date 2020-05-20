# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
import json

class JsonPipeline(object):
    def remove_comma(self, number):
        number = number.replace(',','')
        return float(number)

    def process_item(self, item, spider):
        print(item)
        res = {}
        with open('stock.json', 'r', encoding='utf-8') as fw:
            res = json.load(fw)
            
        print(res)
        result = {item['company']:dict(item)}
        result = {
            item['company']: dict({
            "price" : int(self.remove_comma(item['price'])),
            "ROE": float(self.remove_comma(item['ROE'])),
            "DERatio": float(self.remove_comma(item['DERatio'])),
            "PER": float(self.remove_comma(item['PER'])),
            "BPS": int(self.remove_comma(item['BPS'])),
            "PBR": float(self.remove_comma(item['PBR'])),
        })}
        with open('stock.json', 'w', encoding='utf-8') as f:
            res.update(result)
            f.write(json.dumps(res))
        return item