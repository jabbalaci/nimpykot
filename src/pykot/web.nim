import httpclient


# #######
# Procs #
# #######

proc get_page*(url: string): string =
  ## Fetch a web page and return its content.
  ##
  ## In case of error, return an empty string.
  let client = newHttpClient()
  try:
    client.getContent(url)
  except:
    ""
