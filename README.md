# COVID-19 Data Visualizer: A MATLAB GUI for Pandemic Analytics

## Description
The COVID-19 Data Visualizer is a MATLAB application designed to process, analyze, and visualize the ongoing global data concerning the COVID-19 pandemic. Utilizing data from the Johns Hopkins University's Coronavirus Resource Center, this tool presents a comprehensive, interactive interface for exploring case and death counts across countries, states, and globally, over time. It is built to accommodate regular data updates and provide insightful visualizations to aid in understanding the pandemic's trends.

## Features
- **Dynamic Data Loading:** Automatically loads updated COVID-19 data from a `.mat` file, ensuring the latest statistics are always at your disposal.
- **Object-Oriented Data Structure:** Organizes data into a hierarchy of objects for global, country, and state levels, enabling efficient data management and manipulation.
- **Interactive GUI:** Features an intuitive graphical user interface that includes:
  - A plot area for visual data representation.
  - List boxes for selecting countries and their respective states or territories.
  - Options to choose the number of days for moving average calculations.
  - Toggle buttons for selecting data type (cases, deaths, or both) and data mode (cumulative or daily numbers).
- **Data Integrity Checks:** Implements checks to ensure no negative values are plotted, maintaining the accuracy of visualized data.
- **Customizable Visualizations:** Users can tailor the data plots according to their needs, including adjusting the moving average, selecting specific geographical regions, and focusing on cases, deaths, or both.

## Installation and Usage
1. **Prerequisites:**
   - MATLAB (version R2019b or later) installed on your computer.
   - Access to the latest COVID-19 data file from Johns Hopkins University (provided as a `.mat` file).

2. **Loading the Data:**
   - Ensure the `.mat` file containing the COVID-19 data is in your MATLAB path or working directory.

3. **Launching the Application:**
   - Open MATLAB and navigate to the directory containing the COVID-19 Data Visualizer scripts.
   - Run the main script (e.g., `COVID19DataVisualizer.m`) to launch the application.

4. **Using the Application:**
   - Select a country from the list box to view its COVID-19 data. Choose "Global" for worldwide data.
   - If available, select a state or territory for more localized data.
   - Adjust the moving average days, data type, and data mode using the provided widgets.
   - The plot will automatically update to reflect your selections.


## Acknowledgments
- Data provided by the Coronavirus Resource Center at Johns Hopkins University.
