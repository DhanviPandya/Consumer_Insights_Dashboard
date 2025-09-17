import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# === Setup ===
sns.set_style("whitegrid")
base_path = r"C:\Users\dhanv\Desktop\consumer_insights_project\data\summaries"
plot_dir = r"C:\Users\dhanv\Desktop\consumer_insights_project\python\plots"
os.makedirs(plot_dir, exist_ok=True)

# === Load CSVs ===
files = {
    "age_gender": "age_gender.csv",
    "churn_indicators": "churn_indicators.csv",
    "clv_segments": "clv_segments.csv",
    "customer_category_pairs": "customer_category_pairs.csv",
    "discount_promo_summary": "discount_promo_summary.csv",
    "payment_method_summary": "payment_method_summary.csv",
    "revenue_by_location": "revenue_by_location.csv",
    "season_colour_preference": "season_colour_preference.csv",
    "season_size_preference": "season_size_preference.csv",
    "seasonal_category_trends": "seasonal_category_trends.csv",
    "shipping_revenue_summary": "shipping_revenue_summary.csv"
}

dfs = {}
for key, filename in files.items():
    path = os.path.join(base_path, filename)
    dfs[key] = pd.read_csv(path)
    print(f"Loaded {filename} → shape: {dfs[key].shape}")

# === 1️ Locate Demand & White Space ===
# A. Revenue by Location vs Category Heatmap
rev_df = dfs["revenue_by_location"]
pivot_rev = rev_df.pivot_table(index="Location", columns="Category", values="revenue", aggfunc="sum", fill_value=0)
plt.figure(figsize=(12,8))
sns.heatmap(pivot_rev, cmap="YlGnBu")
plt.title("Revenue by Location vs Category")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "heatmap_revenue_location_category.png"))
plt.close()

# B. Age & Gender Distribution
age_df = dfs["age_gender"]
age_df.plot(kind="bar", x="Gender", y="customers", legend=False, figsize=(8,5))
plt.title("Customer Count by Gender")
plt.ylabel("Customers")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "bar_age_gender.png"))
plt.close()

# === 2️ Understand Seasonal & Regional Behavior ===
# A. Seasonal Purchase Trends by Category Line Chart
seasonal_df = dfs["seasonal_category_trends"]
for cat in seasonal_df["Category"].unique():
    subset = seasonal_df[seasonal_df["Category"] == cat]
    plt.plot(subset["Season"], subset["revenue"], marker='o', label=cat)
plt.legend()
plt.title("Seasonal Purchase Trends by Category")
plt.xlabel("Season")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "line_seasonal_trends.png"))
plt.close()

# B. Stacked Bar: Color Preferences by Season
colour_df = dfs["season_colour_preference"]
colour_pivot = colour_df.pivot(index="Season", columns="Colour", values="purchases").fillna(0)
colour_pivot.plot(kind="bar", stacked=True, figsize=(10,6))
plt.title("Color Preferences by Season")
plt.ylabel("Purchases")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "stackedbar_colour_prefs.png"))
plt.close()

# B2. Stacked Bar: Size Preferences by Season
size_df = dfs["season_size_preference"]
size_pivot = size_df.pivot(index="Season", columns="Size", values="purchases").fillna(0)
size_pivot.plot(kind="bar", stacked=True, figsize=(10,6))
plt.title("Size Preferences by Season")
plt.ylabel("Purchases")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "stackedbar_size_prefs.png"))
plt.close()

# === 3️ Assess Competitive Pressure ===
# A. Discount vs Promo Effectiveness Heatmap
discount_df = dfs["discount_promo_summary"]
pivot_discount = discount_df.pivot_table(index="DiscountApplied", columns="PromoCodeUsed", values="avg_order_value", fill_value=0)
plt.figure(figsize=(8,6))
sns.heatmap(pivot_discount, annot=True, cmap="YlOrRd")
plt.title("Discount vs Promo Effectiveness (Avg Order Value)")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "heatmap_discount_promo.png"))
plt.close()

# B. Shipping Type vs Review Rating Heatmap
ship_df = dfs["shipping_revenue_summary"]
pivot_ship = ship_df.pivot_table(index="ShippingType", values="avg_rating", aggfunc='mean')
plt.figure(figsize=(6,4))
sns.heatmap(pivot_ship, annot=True, cmap="coolwarm")
plt.title("Shipping Type vs Review Rating")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "heatmap_shipping_rating.png"))
plt.close()

# C. Payment Method Usage Bar Chart
pay_df = dfs["payment_method_summary"]
pay_df.plot(kind="bar", x="PaymentMethod", y="transactions", figsize=(8,5))
plt.title("Payment Method Usage")
plt.ylabel("Transactions")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "bar_payment_method.png"))
plt.close()

# === 4️ Advanced / Strategic Insights ===
# A. Customer Lifetime Value Segments Scatter
clv_df = dfs["clv_segments"]
plt.scatter(clv_df["transactions"], clv_df["total_spent"], c=clv_df["prev_purchases"], cmap="viridis", alpha=0.6)
plt.title("CLV Segments: Transactions vs Total Spent")
plt.xlabel("Transactions")
plt.ylabel("Total Spent")
plt.colorbar(label="Previous Purchases")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "scatter_clv_segments.png"))
plt.close()

# B. Churn Indicators Bar Chart
churn_df = dfs["churn_indicators"]
churn_df.plot(kind="bar", x="Location", y="avg_prev_purchases", figsize=(10,5))
plt.title("Churn Risk Indicators by Location")
plt.ylabel("Avg Previous Purchases")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "bar_churn_indicators.png"))
plt.close()

# C. Cross-Category Purchase Patterns Heatmap (Basket Analysis)
pairs_df = dfs["customer_category_pairs"]
basket = pd.crosstab(pairs_df["CustomerID"], pairs_df["Category"])
corr = basket.corr()
plt.figure(figsize=(10,8))
sns.heatmap(corr, cmap="magma")
plt.title("Cross-Category Purchase Correlation")
plt.tight_layout()
plt.savefig(os.path.join(plot_dir, "heatmap_cross_category.png"))
plt.close()

print(f" All plots saved to {plot_dir}")
