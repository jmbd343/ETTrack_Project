<%@ page import="java.util.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Employee Time Tracker</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #CFE8EF;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            width: 100%;
            background-color: #85C7DE;
            color: #333;
            padding: 20px 0;
            text-align: center;
            border-bottom: 3px solid #333;
            position: fixed;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h1 {
            margin: 0;
            font-size: 2.5em;
        }
        header a {
            color: #333;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
            margin: 0 15px;
            transition: color 0.3s ease;
        }
        header a:hover {
            color: #A0C4E2;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 100px auto 30px;
            padding: 30px;
            background-color: #C6DBF0;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .container h2 {
            margin-bottom: 30px;
            color: #85C7DE;
            font-size: 2em;
        }
        .chart-container {
            width: 100%;
            height: 400px;
            margin-top: 30px;
            background-color: #AED1E6;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            padding: 20px;
            position: relative;
        }
    </style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawCharts);

        function drawCharts() {
            drawDailyChart();
            drawWeeklyChart();
            drawMonthlyChart();
        }

        function drawDailyChart() {
            fetch('DailyChartDataServlet')
                .then(response => response.json())
                .then(data => {
                    var chartData = [['Category', 'Hours']];
                    for (let i = 0; i < data.labels.length; i++) {
                        chartData.push([data.labels[i], data.data[i]]);
                    }

                    var dataTable = google.visualization.arrayToDataTable(chartData);

                    var options = {
                        title: 'Daily Tasks'
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('dailyChart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => console.error('Error fetching daily chart data:', error));
        }

        function drawWeeklyChart() {
            fetch('WeeklyChartDataServlet')
                .then(response => response.json())
                .then(data => {
                    var chartData = [['Week', 'Hours']];
                    for (let i = 0; i < data.labels.length; i++) {
                        chartData.push([data.labels[i], data.data[i]]);
                    }

                    var dataTable = google.visualization.arrayToDataTable(chartData);

                    var options = {
                        title: 'Weekly Tasks',
                        hAxis: { title: 'Week' },
                        vAxis: { title: 'Hours' }
                    };

                    var chart = new google.visualization.ColumnChart(document.getElementById('weeklyChart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => console.error('Error fetching weekly chart data:', error));
        }

        function drawMonthlyChart() {
            fetch('MonthlyChartDataServlet')
                .then(response => response.json())
                .then(data => {
                    var chartData = [['Month', 'Hours']];
                    for (let i = 0; i < data.labels.length; i++) {
                        chartData.push([data.labels[i], data.data[i]]);
                    }

                    var dataTable = google.visualization.arrayToDataTable(chartData);

                    var options = {
                        title: 'Monthly Tasks',
                        hAxis: { title: 'Month' },
                        vAxis: { title: 'Hours' }
                    };

                    var chart = new google.visualization.ColumnChart(document.getElementById('monthlyChart'));
                    chart.draw(dataTable, options);
                })
                .catch(error => console.error('Error fetching monthly chart data:', error));
        }
    </script>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
        <div>
            <a href="addTask.jsp">Add Task</a>
            <a href="viewTasks.jsp">View Tasks</a>
            <a href="LogoutServlet">Logout</a>
        </div>
        <div style="margin-right: 20px;">
            <% String username = (String) session.getAttribute("username"); %>
            Welcome, <%= username %>
        </div>
    </header>
    <div class="container">
        <h2>Dashboard</h2>
        <div class="chart-container" id="dailyChart"></div>
        <div class="chart-container" id="weeklyChart"></div>
        <div class="chart-container" id="monthlyChart"></div>
    </div>
</body>
</html>
