#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Nov  3 08:31:24 2024

@author: angelosantos
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 17 08:18:01 2024

@author: angelosantos
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import seaborn as sns


# Paths
file_path = '/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets/Pooled_Estimates_MVPF.xlsx'
#file_path = '/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets/Pooled_Estimates.xlsx'


#output_base_path = '/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Outputs/Effect Sizes'
output_base_path = '/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Outputs/MVPF'


# Chart name
common_title = "Effect Sizes per $1000"
#common_title = "Effect Sizes"


# Ensure output base directory exists
os.makedirs(output_base_path, exist_ok=True)

# Read each sheet in the Excel file into a dictionary of DataFrames
sheets_dict = pd.read_excel(file_path, sheet_name=None)

# Loop through each sheet in the dictionary
for sheet_name, df in sheets_dict.items():
    
    # Create subfolder for the current sheet
    sheet_output_path = os.path.join(output_base_path, sheet_name)
    os.makedirs(sheet_output_path, exist_ok=True)

    # Assuming the file contains columns named Group, Subgroup, Theta, SE, and N
    df['Subgroup'] = df.apply(lambda row: f"{row['Subgroup']} (N = {int(row['N'])})", axis=1)

    # Calculating confidence intervals, rounding to two decimal places
    df['Theta'] = df['Theta'].round(2)
    df['SE'] = df['SE'].round(2)
    df['CI_lower'] = (df['Theta'] - 1.96 * df['SE']).round(2)
    df['CI_upper'] = (df['Theta'] + 1.96 * df['SE']).round(2)

    # Set font to Arial, fallback to default if not found
    plt.rcParams["font.family"] = "Arial"

    # Use seaborn's color palette for a subtle variation in color
    colors = sns.color_palette("muted", len(df['Group'].unique()))

    # Get unique groups for separate plotting
    unique_groups = df['Group'].unique()

    # Loop through each group and create a separate plot
    for idx, group in enumerate(unique_groups):
        group_df = df[df['Group'] == group]
        group_df = group_df.reset_index(drop=True)
        group_df['y_pos'] = np.arange(len(group_df)) * 1  # Position for each row

        # Plotting for the current group
        fig, ax = plt.subplots(figsize=(8, 6))
        
        # Draw a thin vertical red line at x=0
        ax.axvline(x=0, color='red', linewidth=0.5, linestyle='--')

        # Plot each effect size with shaded confidence interval
        for i, row in group_df.iterrows():
            # Use the color for the group based on the color palette
            color = colors[idx]
            
            # Plot with shaded area for CI, without adding labels
            ax.errorbar(row['Theta'], row['y_pos'], fmt='o', color=color, markersize=6, capsize=4)
            ax.fill_betweenx([row['y_pos'] - 0.1, row['y_pos'] + 0.1], row['CI_lower'], row['CI_upper'], color=color, alpha=0.2)

            
        # Set y-ticks to subgroups (includes N in the labels)
        ax.set_yticks(group_df['y_pos'])
        ax.set_yticklabels(group_df['Subgroup'], fontsize=10)
        ax.invert_yaxis()  # Top subgroup at top

        # Labels and title enhancements
        ax.set_xlabel('Effect size (SD)', fontsize=12)
        ax.set_title(f"{common_title} by {group} ({sheet_name})", fontsize=14, fontweight='bold')
        
        # Remove top and right spines
        ax.spines['top'].set_visible(False)
        ax.spines['right'].set_visible(False)

        # Add light horizontal grid lines
        ax.grid(axis='y', linestyle='--', alpha=0.5)

        # Save each figure automatically with group name and sheet name in the filename
        plt.tight_layout()
        plt.savefig(os.path.join(sheet_output_path, f"{group}_es_{sheet_name}.png"), dpi=300)
        plt.close(fig)  # Close the figure after saving to avoid display
