import scrapy
from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException

import json
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname('__file__'))))))

from company_code_naver import company_code
from crawl.items import StockItem

class stockSpider(scrapy.Spider):
    name = "stock"
    
    def __init__(self):
        scrapy.Spider.__init__(self)
        options = webdriver.ChromeOptions()
        options.add_argument('headless')
        self.browser = webdriver.Chrome('chromedriver', chrome_options=options)

    def start_requests(self):
        print ('start_request')
        urls = [ {"url" : ''.join(['https://m.stock.naver.com/item/main.nhn#/stocks/', company_code[x], '/annual']), "company_name" : x} for x in company_code]
        for link in urls:
            print(link["url"])
            yield scrapy.Request(
                url=link["url"],
                meta=link,
                callback=self.parse,
                dont_filter=True
                )
            
    def parse(self, response):
        driver = self.browser
        print('------')
        driver.get(response.meta["url"])
        driver.implicitly_wait(10)
        price = driver.find_element_by_xpath('//*[@id="header"]/div[4]/div[1]/div/div[2]/div/div[2]/div[1]/strong').get_attribute('data-current-price')
        while price == None:
            price = driver.find_element_by_xpath('//*[@id="header"]/div[4]/div[1]/div/div[2]/div/div[2]/div[1]/strong').get_attribute('data-current-price')
            
        ROE = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[6]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        DERatio = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[7]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        PER = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[11]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        BPS = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[12]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        PBR = driver.find_elements_by_xpath('//*[@id="view"]/div/table/tbody/tr[13]/*[contains(@class, "stock_up") or contains(@class, "stock_dn")]')
        length = [len(ROE), len(DERatio), len(PER), len(BPS), len(PBR)]
        lens = min(length)-1
        print(response.meta["company_name"])
        if lens<0:
            print('error')
            return
        yield StockItem(
            company = response.meta["company_name"],
            price = price,
            ROE = ROE[lens].text,
            DERatio = DERatio[lens].text,
            PER = PER[lens].text,
            BPS = BPS[lens].text,
            PBR = PBR[lens].text
        )