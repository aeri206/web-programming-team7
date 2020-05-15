import requests, pprint

example = "https://opendart.fss.or.kr/api/list.json" \
          "?crtfc_key=fad3c5267be6330678a8bd1be6b49c7bf5cba2da" \
          "&corp_code=00126380" \
          "&bgn_de=20180101" \
          "&end_de=20200101" \
          "&last_reprt_at=Y" \
          "&pblntf_ty=A" \
          "&pblntf_detail_ty=A003" \
          "&corp_cls=Y" \
          "&sort=date" \
          "&sort_mth=asc" \
          "&page_no=1" \
          "&page_count=100"
private_key = "fad3c5267be6330678a8bd1be6b49c7bf5cba2da"
corp_code = ""
begin_date = ""
end_date = ""
last_report = ""


response = requests.get(example)
pprint.pprint(response.text)



