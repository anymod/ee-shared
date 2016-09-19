'use strict'

subtags =
  homeAccents: [
    'Home decor accents'
    'Wall Decor'
    'Mirrors'
    'Lamps, bases & shades'
    'Candles & holders'
    'Coat & hat racks'
    'Plants & Flowers'
    'Pillows'
    'General'
  ],
  furniture: [
    'Living room'
		'Dining room'
		'Kitchen'
		'Home entertainment'
		'Home office'
		'Bedroom'
		'Bean Bags'
		'Other'
  ],
  artwork: [
    'Artwork'
  ],
  bedBath: [
    'Comforters'
		'Bedding ensembles'
    'Quilts'
		# 'Sheets & pillowcases'
		'Blankets & throws'
		'Decorative pillows, inserts & covers'
		# 'Bedspreads & coverlets'
		# 'Down/Down Alternative'
		'Bathroom accessories'
		'Bathroom decorations'
		'Bath rugs & mats'
		'Towels & washcloths'
		# 'Bath linen sets'
  ],
  kitchen: [
    'Dinnerware & serving pieces'
    'Kitchen storage & organization'
    # 'Cookware'
    'Cutlery'
    'Linens'
    'Bar tools & glasses'
    # 'Flatware'
    # 'Glassware'
  ],
  outdoor: [
    'Chairs'
    'Tables'
    'Patio furniture sets'
    'Plants & planting'
    'Firepits'
    'Birdhouses & accessories'
    'Birdbaths'
    'Lights & lanterns'
    'Hammocks, stands & accessories'
    'Plaques'
    'General'
  ]

angular.module 'app.core'
  .constant 'perPage', 48
  .constant 'eeEnvironment', '@@eeEnvironment'
  .constant 'eeBackUrl', '@@eeBackUrl/v0/'
  .constant 'eeSecureUrl', '@@eeSecureUrl/'
  .constant 'eeStripeKey', '@@eeStripeKey'
  .constant 'categories', [
    { id: 4, title: 'Home Accents', subtags: subtags.homeAccents }
    { id: 3, title: 'Furniture',    subtags: subtags.furniture }
    { id: 1, title: 'Artwork',      subtags: subtags.artwork }
    { id: 2, title: 'Bed & Bath',   subtags: subtags.bedBath }
    { id: 5, title: 'Kitchen',      subtags: subtags.kitchen }
    { id: 6, title: 'Outdoor',      subtags: subtags.outdoor }
  ]
  .constant 'sortOrders', [
    { order: null,  title: 'Featured' }
    { order: 'pa',  title: '$ - $$$', use: true } # price ASC (pa)
    { order: 'pd',  title: '$$$ - $', use: true } # price DESC (pd)
    { order: 'ta',  title: 'A to Z',  use: true } # title ASC (ta)
    { order: 'td',  title: 'Z to A',  use: true } # title DESC (td)
  ]
  .constant 'defaultMargins', [
    { min: 0,     max: 2499,      margin: 0.20 }
    { min: 2500,  max: 4999,      margin: 0.15 }
    { min: 5000,  max: 9999,      margin: 0.10 }
    { min: 10000, max: 19999,     margin: 0.07 }
    { min: 20000, max: 99999999,  margin: 0.05 }
  ]
  .constant 'stopWords', [
    'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', 'as', 'at',
    'be', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by', 'cannot', 'could', 'did',
    'do', 'does', 'doing', 'down', 'during', 'each', 'few', 'for', 'from', 'had', 'has', 'have', 'he',
    'her', 'here', 'hers', 'him', 'his', 'how', 'i', 'if', 'in', 'into', 'is', 'it', 'its', 'me', 'more',
    'most', 'my', 'no', 'nor', 'not', 'of', 'off', 'on', 'once', 'only', 'or', 'other', 'our', 'ours',
    'out', 'over', 'own', 'same', 'she', 'should', 'so', 'some', 'such', 'than', 'that', 'the', 'them',
    'then', 'there', 'these', 'they', 'this', 'those', 'to', 'too', 'under', 'until', 'up', 'very', 'was',
    'we', 'were', 'where', 'which', 'while', 'with', 'you'
  ]
