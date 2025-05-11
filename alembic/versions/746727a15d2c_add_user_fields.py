"""Add user fields

Revision ID: 746727a15d2c
Revises: d7a1370e0a2e
Create Date: 2025-05-10 16:00:57.641765

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '746727a15d2c'
down_revision: Union[str, None] = 'd7a1370e0a2e'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
