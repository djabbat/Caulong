"""Initial migration

Revision ID: d7a1370e0a2e
Revises: c074a04a735a
Create Date: 2025-05-10 15:31:35.355594

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd7a1370e0a2e'
down_revision: Union[str, None] = 'c074a04a735a'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
