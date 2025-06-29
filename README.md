# Splitwise Clone

A full-stack expense tracking application built with FastAPI (Python) backend and React frontend, similar to Splitwise. This application helps users track shared expenses and manage group finances.

## Features

![sys_overview](https://github.com/user-attachments/assets/c783ae86-5bc2-49c2-944f-7ffd20c0f227)

### Core Functionality
- **User Management**: Create and manage users in the system
- **Group Management**: Create groups with multiple users
- **Expense Tracking**: Add expenses with different split types (equal or percentage)
- **Balance Calculation**: Automatic calculation of who owes whom
- **Settlement System**: Record payments between users to settle debts
- **User/Group Management**: Full CRUD operations with safety checks for outstanding balances
- **Responsive Design**: Beautiful UI with dark/light theme support

### Technical Features
- **Precision Currency Handling**: All monetary values are precisely rounded to 2 decimal places
- **Mathematical Consistency**: Expense splits always add up exactly to the total amount
- **Data Integrity**: Prevention of deletion when outstanding balances exist
- **Dark/Light Theme**: Toggle between themes with localStorage persistence
- **RESTful API**: Well-documented FastAPI backend
- **Real-time Updates**: Automatic balance calculations
- **Responsive Design**: Mobile-friendly interface using TailwindCSS

## Tech Stack

### Backend
- **FastAPI**: Modern, fast web framework for building APIs
- **PostgreSQL**: Robust relational database
- **SQLAlchemy**: Python SQL toolkit and ORM
- **Pydantic**: Data validation using Python type annotations
- **Alembic**: Database migration tool

### Frontend
- **React 18**: Modern React with hooks
- **React Router**: Client-side routing
- **Axios**: HTTP client for API calls
- **TailwindCSS**: Utility-first CSS framework
- **Context API**: State management for theme

### Infrastructure
- **Docker**: Containerization
- **Docker Compose**: Multi-container orchestration

## Quick Start

### Prerequisites
- Docker and Docker Compose installed on your system
- Git (to clone the repository)

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/SimpNick6703/Splitwise-Clone
   cd Splitwise-Clone
   ```

2. **Start the application**
   ```bash
   docker-compose up --build
   ```

   This command will:
   - Build the backend and frontend Docker images
   - Start PostgreSQL database
   - Start the FastAPI backend on port 8000
   - Start the React frontend on port 3000

3. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

4. **Initialize with sample data (optional)**
   ```bash
   # Install Python dependencies for helper scripts
   pip install -r scripts_requirements.txt
   
   # Run the sample data initialization script
   python init_sample_data.py
   ```

### Quick Start Scripts

For convenience, use the provided startup scripts:

**Windows:**
```bash
start.bat
```

**Linux/Mac:**
```bash
chmod +x start.sh
./start.sh
```

### Health Check

To verify all services are running correctly:
```bash
python health_check.py
```

## API Documentation

### User Endpoints
- `POST /users/` - Create a new user
- `GET /users/` - Get all users
- `GET /users/{user_id}` - Get specific user
- `PUT /users/{user_id}` - Update user details
- `DELETE /users/{user_id}` - Delete user (only if no outstanding balances)
- `GET /users/{user_id}/balances` - Get user's balances across all groups

### Group Endpoints
- `POST /groups/` - Create a new group
- `GET /groups/` - Get all groups
- `GET /groups/{group_id}` - Get group details
- `PUT /groups/{group_id}` - Update group details
- `DELETE /groups/{group_id}` - Delete group (only if no outstanding balances)
- `GET /groups/{group_id}/balances` - Get group balances
- `GET /groups/{group_id}/expenses` - Get group expenses
- `POST /groups/{group_id}/members` - Add members to group
- `DELETE /groups/{group_id}/members/{user_id}` - Remove member from group

### Expense Endpoints
- `POST /groups/{group_id}/expenses` - Add expense to group

### Settlement Endpoints
- `POST /settlements` - Record a payment between users
- `GET /groups/{group_id}/settlements` - Get all settlements for a group

### Request/Response Examples

#### Create User
```json
POST /users/
{
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### Create Group
```json
POST /groups/
{
  "name": "Weekend Trip",
  "description": "Our weekend getaway expenses",
  "user_ids": [1, 2, 3]
}
```

#### Add Expense (Equal Split)
```json
POST /groups/1/expenses
{
  "description": "Dinner at restaurant",
  "amount": 120.00,
  "paid_by": 1,
  "split_type": "equal",
  "splits": []
}
```

#### Add Expense (Percentage Split)
```json
POST /groups/1/expenses
{
  "description": "Hotel accommodation",
  "amount": 300.00,
  "paid_by": 1,
  "split_type": "percentage",
  "splits": [
    {"user_id": 1, "percentage": 50.0},
    {"user_id": 2, "percentage": 30.0},
    {"user_id": 3, "percentage": 20.0}
  ]
}
```

## Manual Setup (Without Docker)

### Backend Setup
1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up PostgreSQL database**
   - Install PostgreSQL
   - Create database named `splitwise`
   - Update `DATABASE_URL` in `database.py` if needed

4. **Run the backend**
   ```bash
   python main.py
   ```

### Frontend Setup
1. **Navigate to frontend directory**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the development server**
   ```bash
   npm start
   ```

## Features Overview

### User Interface
- **Dashboard**: Overview of groups, users, and total expenses
- **Groups Page**: Manage groups and create new ones
- **Group Details**: View expenses, balances, and add new expenses
- **Users Page**: Manage users in the system
- **Theme Toggle**: Switch between dark and light themes

### Split Types
1. **Equal Split**: Divides expense equally among all group members
2. **Percentage Split**: Allows custom percentage allocation for each member

### Balance Calculation
The application automatically calculates:
- Individual user balances within groups
- Net amounts owed or to be received
- Simplified debt relationships

## Helper Scripts

The project includes several helper scripts to make development and testing easier:

### Startup Scripts
- `start.bat` (Windows) / `start.sh` (Linux/Mac): Automated startup with Docker
- Checks for Docker availability
- Builds and starts all services
- Provides status updates and URLs

### Sample Data
- `init_sample_data.py`: Populates the application with sample users, groups, and expenses
- Perfect for testing and demo purposes
- Run after the application is started

### Health Check
- `health_check.py`: Verifies all services are running correctly
- Checks backend, frontend, and API documentation availability
- Useful for debugging deployment issues

### Usage
```bash
# Start the application
./start.sh  # or start.bat on Windows

# Check if everything is running
python health_check.py

# Add sample data
python init_sample_data.py
```

## Assumptions Made

1. **No Authentication**: The application doesn't include user authentication for simplicity
2. **No Payment Processing**: Focus is on expense tracking, not actual money transfer
3. **Simplified Debt Calculation**: Uses basic net balance calculation instead of complex debt simplification algorithms
4. **Single Currency**: All amounts are assumed to be in the same currency (INR ₹)
5. **Group Membership**: Users must be added to groups to participate in expenses

## Architecture

### Backend Architecture
```
backend/
├── main.py          # FastAPI application entry point
├── models.py        # SQLAlchemy database models
├── schemas.py       # Pydantic models for request/response
├── database.py      # Database configuration
├── crud.py          # Database operations
└── requirements.txt # Python dependencies
```

### Frontend Architecture
```
frontend/src/
├── components/      # Reusable UI components
├── pages/          # Page components
├── services/       # API service layer
├── context/        # React context providers
├── App.js          # Main application component
└── index.js        # Application entry point
```

## Development

### Adding New Features
1. **Backend**: Add new endpoints in `main.py`, models in `models.py`, and schemas in `schemas.py`
2. **Frontend**: Create new components in `components/` or pages in `pages/`
3. **Database**: Use Alembic for database migrations

### Styling
- Uses TailwindCSS utility classes
- Custom color palette defined in `tailwind.config.js`
- Dark/light theme support with CSS variables

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues and questions, please create an issue in the GitHub repository.
