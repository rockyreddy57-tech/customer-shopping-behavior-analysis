# Customer Shopping Behaviour Analysis

Analysis of 3,900 retail transactions to understand what drives revenue and how customer segments differ, using Python, SQL, and Power BI.

## Tools
Python (Pandas, NumPy, Matplotlib), SQL (SQLite), Power BI

## Dataset
Customer Shopping Trends dataset (Kaggle): 3,900 records, 19 columns covering demographics, purchases, ratings, discounts, subscriptions, and payment methods.

## Process
1. **Data quality check:** no missing values or duplicates; no outliers in age (18-70) or purchase amount ($20-$100)
2. **Cleaning:** standardised column names, merged duplicate frequency labels (Bi-Weekly/Fortnightly, Quarterly/Every 3 Months), created age-group and spend-level features
3. **Analysis:** answered business questions in Python and repeated them in SQL (GROUP BY, CASE WHEN, CTEs, window functions)
4. **Dashboard:** built an interactive Power BI report with KPI cards, charts, and slicers

## Key Insights
- **Revenue:** total revenue of $233K from 3,900 orders, with an average spend of $59.76
- **Categories:** Clothing (45%) and Accessories (32%) drive most revenue; average spend per order is similar in every category, so revenue differs by order volume
- **Seasons:** Fall is the strongest season ($60.0K) and Summer the weakest ($55.8K), about 7% lower
- **Subscriptions:** subscribers spend about the same as non-subscribers ($59.49 vs $59.87)
- **Discounts:** discounted orders show no higher spend ($59.28 vs $60.13) or rating
- **Segments:** spend is consistent across age groups and genders ($58-$62), and no state dominates revenue

## Recommendations
- Focus stock and promotions on Clothing and Accessories, especially in Fall
- Test a Summer campaign to narrow the seasonal gap
- Test whether discounts raise order volume before spending more on them

## Limitations
The dataset appears synthetic, with very even distributions, so differences between segments are small. Findings should be confirmed on real transaction data.

## Dashboard
![Dashboard](Screenshot%202026-11-25%20131029.png)

## Files
- `shopping_trends_clean.csv`: cleaned dataset
- notebook (`.ipynb`): Python analysis
- `queries.sql`: 10 SQL queries
- `shopping_dashboard.pbix`: Power BI report
