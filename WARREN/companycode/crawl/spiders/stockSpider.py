import scrapy
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException

import json
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname('__file__'))))))

import csv
from crawl.items import StockItem

class stockSpider(scrapy.Spider):
    name = "stock"
    
    def __init__(self):
        scrapy.Spider.__init__(self)
        options = webdriver.ChromeOptions()
        options.add_argument('headless')
        self.browser = webdriver.Chrome('chromedriver', chrome_options=options)
        
    def remove_comma(self, number):
        number = number.replace(',','')
        return float(number)

    def start_requests(self):
        
        with open('company_code_only.csv', newline='') as f:
            reader = csv.reader(f)
            data = list(reader)
        
        for code in data:
            x = code[0]
            real_code = '0' * (6-len(x)) + x
            url = ''.join(['https://m.stock.naver.com/item/main.nhn#/stocks/', real_code, '/annual'])
            yield scrapy.Request(
                url=url,
                meta={"url":url, "code": "A"+real_code},
                callback=self.parse,
                dont_filter=True
                )
            
    def parse(self, response):
        driver = self.browser
        driver.get(response.meta["url"])
        driver.implicitly_wait(10)
        price = driver.find_element_by_xpath('//*[@id="header"]/div[4]/div[1]/div/div[2]/div/div[2]/div[1]/strong').get_attribute('data-current-price')
        while price == None:
            price = driver.find_element_by_xpath('//*[@id="header"]/div[4]/div[1]/div/div[2]/div/div[2]/div[1]/strong').get_attribute('data-current-price')
            
        ROE = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[6]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        PER = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[11]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        BPS = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[12]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        PBR = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[13]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        length = [len(ROE), len(PER), len(BPS), len(PBR)]
        lens = min(length)-1
        print('========='+response.meta["code"])
        if lens<0:
            print('error')
            return
        yield StockItem(
            company = response.meta["code"],
            price = self.remove_comma(price),
            ROE = self.remove_comma(ROE[lens].text),
            PER = self.remove_comma(PER[lens].text),
            BPS = self.remove_comma(BPS[lens].text),
            PBR = self.remove_comma(PBR[lens].text)
        )